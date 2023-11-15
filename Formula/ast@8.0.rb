# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d09cfd65bc5aa34893dabf11480a5b63aa4ec0d99888e5d81a435a096509dfd9"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2d4d541ca860d8fcd33cec3dd8791ef692022f0805ced993113068041b59737d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "792c9a4acf67496cb9c75012973c3da549d0fa6b8b5f6758a2fa1d732dc5c503"
    sha256 cellar: :any_skip_relocation, ventura:        "70b488fc709c441ea79be5d52ce8e1584925bcdfe49cdd4e5e40f5ffd48e60a4"
    sha256 cellar: :any_skip_relocation, monterey:       "a3ffd1928acc7612276e08f1017ad75d65111d19939054155ac4ca26ed606c2b"
    sha256 cellar: :any_skip_relocation, big_sur:        "55ab9f0fb92593dbf6f44cbe311fd6706d4ab0bccfc6fb49311bff9a8db87f45"
    sha256 cellar: :any_skip_relocation, catalina:       "ca39804328d2fd98db4d5eef8ac7d92dd2723e65ee00411ea65210db763cf202"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cb98022ee17157d5c01905e7e6d46e599779091090ac8dca59aaaffa5925d0ad"
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
