# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT80 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.4.tgz"
  sha256 "1b16ae5e17736e2ce892fd96145fa8b9e1724106458535d0c7e3d4093a9091a9"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "66c582768cd56064e368ba5aa80df7a367eb9c503373de5011917e022aea3da9"
    sha256 cellar: :any,                 arm64_sonoma:  "d269af098eb5d7e744117fc655b0c3ff89a83e1068e809d3582fa069d326fb5a"
    sha256 cellar: :any,                 arm64_ventura: "7cd4a8b8efe23e48b9de0ea59b581cd9478f7fee0d96a8b74e1c3cbb338fb04b"
    sha256 cellar: :any,                 ventura:       "d457edb901e3ba22c19c2a4c3275aaaf4b2444acc8d5a9dc8ac7f313fe89ace4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4c15db4d4e61052f6c6e9f26cbd44640551398b26ad134527cbc85b626dbaee1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3c6198576d96824dcaba487ffeeb49e60fe492d3b25d04d19376de19ecfc2667"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
