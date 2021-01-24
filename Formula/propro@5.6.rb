# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Propro Extension
class ProproAT56 < AbstractPhp56Extension
  init
  desc "Propro PHP extension"
  homepage "https://github.com/m6w6/ext-propro"
  url "https://pecl.php.net/get/propro-1.0.2.tgz"
  sha256 "6b4e785adcc8378148c7ad06aa82e71e1d45c7ea5dbebea9ea9a38fee14e62e7"
  head "https://github.com/m6w6/ext-propro.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "139429a1b065cc5cd39851bd45d31483ec723d66fd6226c10bed9b6e3ccda501" => :big_sur
    sha256 "c4cdcf1c88d5cc96fe3dff38017876f888756065ab852df863b01b0baf558f12" => :arm64_big_sur
    sha256 "58c425078c02fbcbe49287bf4fde176becf30802e5c58896403c75d0dc84bc5f" => :catalina
  end

  def install
    Dir.chdir "propro-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-propro"
    system "make"
    prefix.install "modules/propro.so"
    write_config_file
  end
end
