# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Igbinary Extension
class IgbinaryAT71 < AbstractPhpExtension
  init
  desc "Igbinary PHP extension"
  homepage "https://github.com/igbinary/igbinary"
  url "https://github.com/igbinary/igbinary/archive/3.2.7.tar.gz"
  sha256 "21863908348f90a8a895c8e92e0ec83c9cf9faffcfd70118b06fe2dca30eaa96"
  head "https://github.com/igbinary/igbinary.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "e60499df8804fb7654951e9ce19f264960e587466fb74f026e7995ce8c39210a"
    sha256 cellar: :any_skip_relocation, big_sur:       "62c45046bbcc17e750ca5a98b70a6a07d0df68618528066753e226696e3c27a9"
    sha256 cellar: :any_skip_relocation, catalina:      "0db2899df4793af548caa6862ae86c37e7e96b1bbaf966563a2b0bc7e157d7f4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c2114220b6becdea8983950e411f6bd517bab08802b9204335e976f09b3fd3f1"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-igbinary"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    Dir.chdir "src/php7"
    add_include_files
  end
end
