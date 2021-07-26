# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT81 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://github.com/shivammathur/apcu/archive/90279ca8fe062a8c595ceebac339a3e4c9a3ebab.tar.gz"
  sha256 "b0e3b1ede3fdc98d56d40952600405bb69ba23f3d39c2a6821af8be09b6110eb"
  version "5.1.20"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "1c6a37aa7c1655a163dfedaf833e0eb7d71eace706891c376e7e57138a2b4953"
    sha256 cellar: :any_skip_relocation, big_sur:       "22e41a784d8551fc4d8b4f346eff96477e0d9b06f25c2240c6126846c91c4e16"
    sha256 cellar: :any_skip_relocation, catalina:      "44b740def32aedbc10c8f84c1aa80eaa38dbe205d75ef36927744913a970a0ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0aa6ae858f02cda5c09c982fd2927455f5c28325476c40f9f17fcd97e7b1ba2d"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
