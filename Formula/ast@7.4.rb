# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT74 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.4.tgz"
  sha256 "28728fb8bfd8b0eddccd241f92f0be0a45d83250e5a0cd6e1876c0c533ab3658"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/ast/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "02e284df15dc64bfb44a138a4484adcc0c3aa67ad6f0156f0a4955c3a4ebe2b4"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "7181c60332daf63140099a1294107bbe0ebda2a87f4431c7963347ae06f728bd"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "b662f0bfa79d98b09c912ebbb4bf35077cd471c0355388e17e855841cabf403a"
    sha256 cellar: :any,                 arm64_linux:       "f737fdb94fea08aaf36dd08c1ca23e80787705b013ea0bd7790ff696ebfd2378"
    sha256 cellar: :any,                 x86_64_linux:      "497e33e6ec1545e713ed6c23cdd224fde2a1a3ef8f9695f6be38deec39a70626"
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
