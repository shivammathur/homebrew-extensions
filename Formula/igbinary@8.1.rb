# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT81 < AbstractPhp81Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    rebuild 7
    sha256 cellar: :any_skip_relocation, big_sur:       "32dcb0d48b1767d47cd212b202a3214805392dc77ba30fad3880838149007b55"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4f0ef624e511c56fe7306b23b26ff7778d6e5a74cf7450c4810846935c442e75"
    sha256 cellar: :any_skip_relocation, catalina:      "8ad28545150f81e2617d202420fc5ddbeaf663ed88100ef0c20f987e0afbca75"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
