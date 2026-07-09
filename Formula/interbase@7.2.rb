# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Interbase Extension
class InterbaseAT72 < AbstractPhpExtension
  env :std

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_tahoe:   "4e771f7f6884185fb243b8a71641e07cbfd929b4eff2b8e808b6cf20d859ded3"
    sha256 cellar: :any, arm64_sequoia: "03b6203a2e6aef9ebde3668604423f28bfc1218c7955fb8137d0b86766ca2c3b"
    sha256 cellar: :any, arm64_sonoma:  "4e1f9d769f28684a42f091471ee92564db8b0d68cd1b5f9e588fb2c84b10b21e"
    sha256 cellar: :any, sonoma:        "28fac14f1b43f9396d92787eb795e29ad4362af40fef9a0d85a6df038f0cf046"
    sha256 cellar: :any, arm64_linux:   "d42b40dd374ff5a6ffaf5d677a83f82a068000f9fcb95cbe5b75b08fed1acca8"
    sha256 cellar: :any, x86_64_linux:  "f8e661ef33d9228371703a2ed04601ec49d37eba4fd317f1922eb3801314ecc1"
  end
  init
  desc "Interbase (Firebird) PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/418ed8a42fc1ff3f1f434873c4d453713d4164ea.tar.gz"
  version "7.2.34"
  sha256 "8b8104c40d0e453088f8fe703a0ead74ffdb5a4d0deb9b102864aa206bef5d2b"
  license "PHP-3.01"

  depends_on "shivammathur/extensions/firebird-client@3"

  def install
    fb_prefix = Utils::Path.formula_opt_prefix("shivammathur/extensions/firebird-client@3")
    args = %W[
      --with-interbase=shared,#{fb_prefix}
    ]
    Dir.chdir buildpath/"ext/interbase" do
      safe_phpize
      system "./configure", "--prefix=#{prefix}", phpconfig, *args
      system "make"
      prefix.install "modules/#{extension}.so"
      write_config_file
      add_include_files
    end
  end
end
