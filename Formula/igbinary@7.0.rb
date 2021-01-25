# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT70 < AbstractPhp70Extension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.1.tar.gz"
  sha256 "bc26f361f750bc9894741201e6851a3445a20d185969c08bf311264b7dc9cd6b"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://dl.bintray.com/shivammathur/extensions"
    cellar :any_skip_relocation
    sha256 "910556e3c9554c68f57ef36d74cb7b98de0a0c4b9f0c3bcbe2b503ee49bde1fe" => :big_sur
    sha256 "5804675baa5fa7eaa8b9cac18ad59d0db3e0335fbfcf97d78cd8db298c2861c8" => :arm64_big_sur
    sha256 "5b76a228c982cd33eb331b28476925e49997f9a7d17b75cfb6944cebeb04501e" => :catalina
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{module_name}.so"
    write_config_file
  end
end
