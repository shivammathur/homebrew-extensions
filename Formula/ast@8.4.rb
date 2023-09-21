# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ast Extension
class AstAT84 < AbstractPhpExtension
  init
  desc "Ast PHP extension"
  homepage "https://github.com/nikic/php-ast"
  url "https://pecl.php.net/get/ast-1.1.0.tgz"
  sha256 "ee3d4f67e24d82e4d340806a24052012e4954d223122949377665427443e6d13"
  head "https://github.com/nikic/php-ast.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d489242ded90c6d3c7d5bdb0c2eec521cf569d1484302907a0a770cae144acef"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ae74cb33f6707c7d36d5d14b582ad854ae27638ef4d42873a688dd57fe22e9c2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "21bd04eeb8847b138d8a89429d4125fd224e377e9d8843084c1dc59413c6f222"
    sha256 cellar: :any_skip_relocation, ventura:        "0c163cd5011f623d12b43d415c9e9dab24e02c487891937305f345effc059898"
    sha256 cellar: :any_skip_relocation, monterey:       "d8bb8868fe1bcf6c5e4aba5bc2d9dcfada0f4d9da7211401787c6901da924294"
    sha256 cellar: :any_skip_relocation, big_sur:        "89f5960c39901518e76e7dfd7fae5895cff347c927f3026f93fc02d1047c6b48"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "549f424be19c6b98e6b42489cbd8454abb3fff677c6efe366224e721f19b7dc9"
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
