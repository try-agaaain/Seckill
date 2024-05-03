package cn.hfbin.seckill;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.amqp.core.Queue;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
@MapperScan("cn.hfbin.seckill.dao")
public class SeckillApplication {
	@Bean
	public Queue seckillQueue() {
		return new Queue("seckill.queue");
	}

	public static void main(String[] args) {
		SpringApplication.run(SeckillApplication.class, args);
	}


}
