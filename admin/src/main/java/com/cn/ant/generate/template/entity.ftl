package ${packageName}.${moduleName}.entity${subModuleName};

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import org.hibernate.annotations.Cache;
import org.hibernate.annotations.CacheConcurrencyStrategy;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;
import org.hibernate.validator.constraints.Length;

import com.cn.ant.common.persistence.DataEntity;
import com.cn.ant.modules.sys.entity.User;

/**
 * ${functionName}Entity
 * @author ${classAuthor}
 * @version ${classVersion}
 */
public class ${ClassName} extends DataEntity {
	
	private static final long serialVersionUID = 1L;
	private Long id; 		// 编号
	private String name; 	// 名称

	public ${ClassName}() {
		super();
	}

	public ${ClassName}(Long id){
		this();
		this.id = id;
	}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
}


