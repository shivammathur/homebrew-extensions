# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT71 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.0.16.tgz"
  sha256 "45bda34b780c4661ce77cf65cd8a504fb56526d4b456edcc97d791c86f3879ce"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "eeff458710a522dd06600f7a46aa80b874370c0e11f82248d2dd82c528a189b4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2d11072b373bfdd33d6f8611204f9f29040c94b6b60a65684848eaf698f40fa8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "477e5283b2263c510ad0c9ff38ed5799547999cd0048665e262dba5bf2f5fbf8"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "c0a0439a7ca580fa40ee38e61138225e2fbc487e688c0dbb67ee813a0e11f9ac"
    sha256 cellar: :any_skip_relocation, ventura:        "8636b228ad09b9d1fb832f4964c7dd5859f535cb94765856054a9fcd1ca3f05f"
    sha256 cellar: :any_skip_relocation, monterey:       "caa89a0afd5f41873bcf63ba29cae936409af8f2e03c11d84b262cc47db73753"
    sha256 cellar: :any_skip_relocation, big_sur:        "b0790c7e79fd426429f8d215d16470dbe87d9c4e556317cc698eed812304a81a"
    sha256 cellar: :any_skip_relocation, catalina:       "4d42af8e5acfe0c298460e97f40ad4c74f7cd79097a433ca18da81f6beb30ba1"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "b397bb1a818feb256506bfdbb40cfe203cced30d32ee90a9917b80252ada1869"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "8e95824496ec04ff89d9dc63abee9db0061a95c10225c6d0a35e81f6a8fb03c9"
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
