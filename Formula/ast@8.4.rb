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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "e89920f1f6313da5ac33938c79ca181cf21036d498d2316e6f3617b2773f353a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "7be0349d0d7722dd640fc77033f28ff371e4ec07073c4a21663782967661d031"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "4446fc33e684fc1798e0ed60e3c8dcb7bdd0bb7337148cf6d0d22d6e1eb56f85"
    sha256 cellar: :any_skip_relocation, ventura:        "2a2ad9208ad1fae51ebf5eeb4144f0f52baabe581bf21ef23b746b5bbbde8080"
    sha256 cellar: :any_skip_relocation, monterey:       "6b1d18dc99818161880eccf380ffd1aa2ccfd0a4b06ff29a7a6d3abe0102ec75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b7ebee1d81147805146d51a8183a35207713f1ecd75459b7aa466d9d9d6b10c4"
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
