# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT73 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.1.tgz"
  sha256 "0c55e09a4da43b9cc1da72ecb4ae892941f73e157b73d46326bc6a5ed7fc44b1"
  head "https://github.com/nikic/php-ast.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "07f5e4ae3704d7622c1ae7ef102dce9aff5bcbfe98a901bb88543b47b3cf5a35"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "aece6ea0a56af00804846e61f2f86eb2873c01a2b2af2c9a9198f71c3fef812a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "cf9257a05a51025e92282c54b63586f1adeb4ec9fba35e43aae4f85de6ce64e3"
    sha256 cellar: :any_skip_relocation, ventura:        "78163d4517aa1427febdf9c5a0ea3e8278cb52a0c2e0825e6a28bae0a02642ca"
    sha256 cellar: :any_skip_relocation, monterey:       "3bc793c58065fb4e93bfd73ed27f1c2b130e6f70ee245e01876c0224b561c009"
    sha256 cellar: :any_skip_relocation, big_sur:        "5a2637081a67332111eb75aba8eba662010be419d1acf446d51f91b808166652"
    sha256 cellar: :any_skip_relocation, catalina:       "a7816f80593bfb89e2853a4e5a90d90e36166a9eb405c2682e5b0cbcfea19114"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7f27825c7d417352ff7f966504d536ae59752b118fd7499a253dfe5071de63c7"
  end

  def install
    Dir.chdir "ast-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ast"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
