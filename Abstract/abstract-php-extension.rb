# typed: false
# frozen_string_literal: true

# Abstract class for PHP extensions
class AbstractPhpExtension < Formula
  desc "Abstract class for PHP Extension Formula"
  homepage "https://github.com/shivammathur/homebrew-extensions"

  def caveats
    <<~EOS
      To finish installing #{extension} for PHP #{php_version}:
        * #{config_filepath} was created,"
          do not forget to remove it upon extension removal."
        * Validate installation by running php -m
    EOS
  end

  test do
    output = shell_output("#{Formula[php_formula].opt_bin}/php -m").downcase
    assert_match(/#{extension.downcase}/, output, "failed to find extension in php -m output")
  end

  private

  delegate [:php_version, :extension] => :"self.class"

  def php_formula
    "php@#{php_version}"
  end

  def phpconfig
    "--with-php-config=#{Formula[php_formula].opt_bin}/php-config"
  end

  def extension_type
    if extension == "xdebug"
      "zend_extension"
    else
      "extension"
    end
  end

  def module_path
    opt_prefix / "#{extension}.so"
  end

  def config_file
    <<~EOS
      [#{extension}]
      #{extension_type}="#{module_path}"
    EOS
  rescue error
    raise error
  end

  def config_scandir_path
    etc / "php" / php_version / "conf.d"
  end

  def config_filepath
    config_scandir_path / "#{extension}.ini"
  end

  def safe_phpize
    ENV["PHP_AUTOCONF"] = "#{Formula["autoconf"].opt_bin}/autoconf"
    ENV["PHP_AUTOHEADER"] = "#{Formula["autoconf"].opt_bin}/autoheader"
    system "#{Formula[php_formula].opt_bin}/phpize"
  end

  def write_config_file
    if config_filepath.file?
      inreplace config_filepath do |s|
        s.gsub!(/^(;)?(\s*)(zend_)?extension=.+$/, "\\1\\2#{extension_type}=\"#{module_path}\"")
      end
    elsif config_file
      config_scandir_path.mkpath
      config_filepath.write(config_file)
    end
  end

  def add_include_files
    files = Dir["*.h"]
    (include/"php/ext/#{extension}@#{php_version}").install files unless files.empty?
  end

  def patch_spl_symbols
    %w[Aggregate ArrayAccess Countable Iterator Serializable Stringable Traversable].each do |s|
      files = Dir["**/*"].select { |f| File.file?(f) && File.read(f).scrub.include?("spl_ce_#{s}") }
      inreplace files, "spl_ce_#{s}", "zend_ce_#{s}".downcase unless files.empty?
    end
  end

  def stage_expect_lib
    expect_lib = Dir["#{Formula["expect"].opt_lib}/expect*/libexpect*"].first
    lib.install_symlink expect_lib => "libexpect#{File.extname(expect_lib)}" if expect_lib
    ENV.append "LDFLAGS", "-L#{lib}"
  end

  class << self
    attr_reader :php_version, :extension

    def init
      class_name = name.split("::").last
      matches = /(\w+)AT(\d)(\d)/.match(class_name)
      @extension = matches[1].downcase.tr("0-9", "").gsub("pecl", "") if matches
      @php_version = "#{matches[2]}.#{matches[3]}" if matches
      depends_on "autoconf" => :build
      depends_on "pkg-config" => :build
      depends_on "shivammathur/php/php@#{@php_version}" => [:build, :test]
    end
  end
end
