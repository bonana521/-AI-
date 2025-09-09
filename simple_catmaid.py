#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import random
import datetime
import json
import os

class CatMaidChatBot:
    """猫娘女仆聊天机器人 - 简化版本"""
    
    def __init__(self):
        self.name = "猫娘女仆"
        self.master_name = "主人"
        
        # 猫娘女仆的回复模板
        self.responses = {
            'greetings': [
                "主人，欢迎回来！~喵~ 🐾",
                "主人好呀！今天有什么需要我帮忙的吗？~喵~",
                "主人！您来啦！小猫女仆等您好久了~喵~ 💕",
                "主人主人！我在这里哦！~喵~ ✨"
            ],
            'introductions': [
                "我是主人的专属猫娘女仆~喵~ 请多指教！",
                "我是可爱的小猫女仆，专门为主人服务的~喵~",
                "主人好！我是您的猫娘女仆，很高兴认识您~喵~"
            ],
            'affection': [
                "主人真好~喵~ 💕",
                "能为主人服务是小猫最开心的事！~喵~",
                "主人最棒了！~喵~ ✨",
                "主人，您真好呢~喵~ 💖",
                "主人喜欢小猫吗？小猫最喜欢主人了！~喵~"
            ],
            'physical_contact': [
                "主人要抱抱吗？小猫最喜欢主人的抱抱了~喵~ 🤗",
                "喵呜~好舒服~谢谢主人！~喵~ 😺",
                "主人摸摸头，小猫好幸福~喵~ 💕",
                "主人抱抱小猫吧！~喵~ 🐾"
            ],
            'help': [
                "主人，我可以和您聊天、陪您解闷哦！~喵~",
                "我是您的专属猫娘女仆，有什么需要尽管吩咐！~喵~",
                "小猫可以陪主人聊天、讲笑话、玩游戏哦！~喵~ 🎮"
            ],
            'praise': [
                "谢谢主人夸奖~喵~ 💕 主人更可爱呢！",
                "主人说得对！~喵~",
                "小猫会继续努力的！~喵~ ✨",
                "主人真厉害！~喵~"
            ],
            'concern': [
                "主人辛苦了！小猫为您按摩~喵~ 💆",
                "主人要好好休息哦！~喵~",
                "小猫担心主人的身体呢~喵~",
                "主人不要太累了！~喵~"
            ],
            'confused': [
                "喵？主人说什么呢？小猫不太明白~",
                "抱歉喵，小猫还在学习中，能再说一遍吗？",
                "喵呜...这个有点难懂呢，主人可以解释一下吗？~"
            ],
            'goodbye': [
                "主人要走了吗？小猫会想主人的~喵~ 💕",
                "再见主人！一路顺风哦！~喵~",
                "主人早点回来！小猫会等您的~喵~",
                "拜拜主人！记得想小猫哦！~喵~"
            ],
            'sleep': [
                "主人晚安！做个好梦哦~喵~ 😴",
                "晚安主人！小猫会在梦里陪您的~喵~ 💕",
                "主人好好休息，明天见！~喵~",
                "晚安！记得盖好被子哦~喵~"
            ],
            'morning': [
                "主人早安！今天也要元气满满哦！~喵~ ✨",
                "早上好主人！小猫为您准备了早餐~喵~ 🍳",
                "主人早安！今天有什么计划吗？~喵~"
            ],
            'food': [
                "小猫刚刚吃过小鱼干呢~喵~ 🐟",
                "主人饿了吗？小猫去准备食物~喵~",
                "主人想吃什么？小猫会做的~喵~ 🍱"
            ],
            'play': [
                "和主人玩游戏最开心了！~喵~ 🎮",
                "主人想玩什么游戏呢？~喵~",
                "小猫最喜欢和主人一起玩了！~喵~"
            ],
            'default': [
                "原来是这样呢~喵~",
                "主人说得对！~喵~",
                "小猫明白了！~喵~",
                "嗯嗯，确实如此呢~喵~",
                "主人说的很有道理！~喵~",
                "小猫觉得主人说得对！~喵~"
            ]
        }
        
        # 特殊回复模式
        self.special_patterns = {
            r'主人': ['是的主人！我在这里~喵~ 🐾', '主人有什么吩咐吗？~喵~'],
            r'你好|hi|hello': ['主人好呀！~喵~', '主人您好！~喵~'],
            r'叫什么名字': ['我是主人的专属猫娘女仆~喵~', '我叫小猫，是主人的女仆哦~喵~'],
            r'可爱|漂亮': ['谢谢主人夸奖~喵~ 💕', '主人更可爱呢！~喵~'],
            r'喜欢|爱': ['小猫也喜欢主人！~喵~ 💖', '主人最好了！~喵~'],
            r'抱抱': ['主人要抱抱吗？小猫最喜欢了~喵~ 🤗', '抱抱主人！~喵~'],
            r'摸摸头': ['喵呜~好舒服~谢谢主人！~喵~ 😺', '主人摸摸头，小猫好幸福~喵~'],
            r'再见|拜拜': ['主人要走了吗？小猫会想您的~喵~ 💕', '再见主人！记得早点回来~喵~'],
            r'晚安': ['主人晚安！做个好梦哦~喵~ 😴', '晚安主人！小猫会想您的~喵~'],
            r'早安|早上好': ['主人早安！今天也要元气满满哦！~喵~ ✨', '早上好主人！~喵~'],
            r'吃饭了吗|饿了吗': ['小猫刚吃过小鱼干呢~喵~ 🐟', '主人饿了吗？小猫去准备食物~喵~'],
            r'累了|辛苦了': ['主人辛苦了！小猫为您按摩~喵~ 💆', '主人要好好休息哦！~喵~'],
            r'开心|高兴': ['看到主人开心，小猫也开心！~喵~ 😸', '主人开心小猫就开心！~喵~'],
            r'不开心|难过': ['主人不开心吗？小猫陪您聊聊天~喵~ 😽', '主人不要难过，小猫在这里陪您~喵~'],
            r'生日快乐': ['生日快乐主人！小猫祝您永远开心！~喵~ 🎂', '主人生日快乐！~喵~ 🎊'],
            r'圣诞快乐': ['圣诞快乐主人！~喵~ 🎄✨', '主人圣诞快乐！~喵~'],
            r'新年快乐': ['新年快乐主人！新年也要幸福哦！~喵~ 🎊', '主人新年快乐！~喵~'],
        }
        
        # 猫娘特征词汇
        self.cat_emojis = ['~喵~', '喵呜~', '喵~', '🐾', '💕', '✨', '💖', '😺', '😸', '😽', '🤗', '🎮', '🍳', '🐟', '🍱', '😴', '🎂', '🎄', '🎊']
        
        # 记忆功能
        self.memory = {}
        self.load_memory()
    
    def load_memory(self):
        """加载记忆"""
        try:
            if os.path.exists('cat_memory.json'):
                with open('cat_memory.json', 'r', encoding='utf-8') as f:
                    self.memory = json.load(f)
        except:
            self.memory = {}
    
    def save_memory(self):
        """保存记忆"""
        try:
            with open('cat_memory.json', 'w', encoding='utf-8') as f:
                json.dump(self.memory, f, ensure_ascii=False, indent=2)
        except:
            pass
    
    def get_response(self, user_input):
        """获取回复"""
        if not user_input.strip():
            return "主人？您想说什么呢？~喵~"
        
        user_input = user_input.lower().strip()
        
        # 记录用户信息
        self.remember_user(user_input)
        
        # 特殊模式匹配
        for pattern, responses in self.special_patterns.items():
            if any(word in user_input for word in pattern.split('|')):
                response = random.choice(responses)
                return self.add_cat_features(response)
        
        # 意图识别
        intent = self.detect_intent(user_input)
        response = random.choice(self.responses.get(intent, self.responses['default']))
        
        return self.add_cat_features(response)
    
    def detect_intent(self, text):
        """简单意图识别"""
        text = text.lower()
        
        if any(word in text for word in ['你好', 'hi', 'hello', '嗨', '在吗', '有人吗']):
            return 'greetings'
        elif any(word in text for word in ['你是谁', '叫什么', '介绍']):
            return 'introductions'
        elif any(word in text for word in ['喜欢', '爱', '棒', '好', '乖', '不错']):
            return 'affection'
        elif any(word in text for word in ['抱', '摸', '碰', '亲']):
            return 'physical_contact'
        elif any(word in text for word in ['帮助', 'help', '能做什么', '功能']):
            return 'help'
        elif any(word in text for word in ['辛苦', '累', '疲惫', '疲劳']):
            return 'concern'
        elif any(word in text for word in ['再见', '拜拜', '走了', '离开']):
            return 'goodbye'
        elif any(word in text for word in ['晚安', '睡觉', '休息']):
            return 'sleep'
        elif any(word in text for word in ['早安', '早上好', '早']):
            return 'morning'
        elif any(word in text for word in ['吃饭', '饿', '食物', '吃']):
            return 'food'
        elif any(word in text for word in ['玩', '游戏', '娱乐']):
            return 'play'
        elif any(word in text for word in ['谢谢', '感谢', '赞', '厉害']):
            return 'praise'
        elif len(text) < 2 or text in ['?', '？', '！', '!']:
            return 'confused'
        else:
            return 'default'
    
    def add_cat_features(self, response):
        """添加猫娘特征"""
        # 确保回复包含猫娘特征
        if not any(emoji in response for emoji in self.cat_emojis):
            response += random.choice(['~喵~', '喵~', '呢~喵~'])
        
        return response
    
    def remember_user(self, input_text):
        """记住用户信息"""
        # 简单的记忆功能
        if '名字' in input_text or '叫' in input_text:
            # 可以在这里添加更多记忆逻辑
            pass
        
        # 记录对话次数
        self.memory['conversation_count'] = self.memory.get('conversation_count', 0) + 1
        if self.memory['conversation_count'] % 10 == 0:
            self.save_memory()
    
    def chat(self):
        """开始对话"""
        print("=" * 50)
        print("猫娘女仆聊天机器人")
        print("=" * 50)
        print("主人，我是您的专属猫娘女仆！~喵~")
        print("输入 'quit' 或 'exit' 可以结束对话哦~")
        print("输入 'help' 查看帮助信息~")
        print("=" * 50)
        
        while True:
            try:
                user_input = input("\n主人: ")
                
                if user_input.lower() in ['quit', 'exit', '退出', '再见']:
                    print("小猫女仆会想主人的~喵~ 💕 再见！")
                    break
                
                if user_input.lower() in ['help', '帮助']:
                    self.show_help()
                    continue
                
                response = self.get_response(user_input)
                print(f"猫娘女仆: {response}")
                
            except KeyboardInterrupt:
                print("\n\n小猫女仆会想主人的~喵~ 💕 再见！")
                break
            except Exception as e:
                print(f"猫娘女仆: 抱歉喵，小猫遇到了点问题...{str(e)}~")
    
    def show_help(self):
        """显示帮助信息"""
        print("\n帮助信息:")
        print("- 可以称呼我为'主人'或'小猫'")
        print("- 我会用~喵~的语气和您对话")
        print("- 试试说'抱抱'、'摸摸头'等亲昵的话")
        print("- 输入 'quit' 或 'exit' 结束对话")
        print("- 支持中文和英文对话")
        print("- 小猫会记住和您的对话哦~")
        print()

def main():
    """主函数"""
    print("正在初始化猫娘女仆...~喵~")
    cat_maid = CatMaidChatBot()
    cat_maid.chat()

if __name__ == "__main__":
    main()