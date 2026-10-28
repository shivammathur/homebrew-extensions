# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT81 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "d28d29a50b8aa5c4d219b0f21b425f8c3217c86ab0b85632b4600269de572767"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "62f40fac8e007272aa37bee5000c4368b1fd5c758dca363631458862e7c8311c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "bd6b032777d396070e66903fabd8f694e4a8aae754fcb7fc951442af7b54f470"
    sha256 cellar: :any,                 arm64_linux:       "15c14631f3b05d45f5895440985811d59424a4f4fcedb6ab96d8fad24333b949"
    sha256 cellar: :any,                 x86_64_linux:      "d9f074de1a03acf9b1e742e213adea0c6787c43e424e10ec13e0cbcb7761aef7"
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
