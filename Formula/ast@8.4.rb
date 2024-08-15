# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT84 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.2.tgz"
  sha256 "8742427ff7c07ba93f940968f7363972ea040d97d847da3b79b4283c2a369dea"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "95cc1b2c054b84be1025d237aa9e0c9682d38f507cf886b505868aa065760d94"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5dd00494f48175d679f212f8ceaeeba3b443fb16a3a862ba3b829de250062bea"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bad9cd28d84ec6b99569b732030e5afe1483b9a7fcdf78407d5179b6d234fad2"
    sha256 cellar: :any_skip_relocation, ventura:        "28b22e574013f46c1cbd0fbb9ecdf2269dec3b1591064197fc3571ef2576d5f8"
    sha256 cellar: :any_skip_relocation, monterey:       "ac6790198ddcf7b9715273bb2b067ad38308068f640f598eb681c7c8e3d2d797"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7760e6627ab2c26713302fdc22935a742f8a1e97052c7ca44866ca62640d695a"
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
