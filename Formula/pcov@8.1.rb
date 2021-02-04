# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for PCOV Extension
class PcovAT81 < AbstractPhp81Extension
  init
  desc "PCOV PHP extension"
  homepage "https://github.com/krakjoe/pcov"
  url "https://github.com/krakjoe/pcov/archive/v1.0.6.tar.gz"
  sha256 "3be3b8af91c43db70c4893dd2552c9ee2877e9cf32f59a607846c9ceb64a173b"
  head "https://github.com/krakjoe/pcov.git"
  license "PHP-3.01"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 25
    sha256 cellar: :any_skip_relocation, big_sur:       "f22410971515bee3c1172dccc8a9461bf4dd92f005a61128246b0fae9112d39b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "c5c71f24bc5549c3b29d6d1133d268907d728d1b0cf62a5e501fefaef6282a55"
    sha256 cellar: :any_skip_relocation, catalina:      "e8eedfd15989c6643129ac3bcda30a2a210ebdbece0fee8c683f6271096f40bd"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-pcov"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
