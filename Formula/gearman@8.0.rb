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

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia:  "1974a0f6a669ce434d69d893b81d65085d18167fcf8cdc5fd92bc7096cd4e432"
    sha256 cellar: :any,                 arm64_sonoma:   "de5415c7f756a314e9224c3b3acecaeaa29d86f57d6cc42480c44d13851d32cf"
    sha256 cellar: :any,                 arm64_ventura:  "8c4e700fbddcb360b2699545d6bac100a183712f0ba41b06ad9c0120047a2809"
    sha256 cellar: :any,                 arm64_monterey: "d5451e51b076ce2fd4cf1066f4edb1282d5bbef94b7e9b165988407fb40d59a6"
    sha256 cellar: :any,                 ventura:        "0d3e42536d1bf194f2618eef38d014fc4fafa684fd6d1e4de2900f427aaa1207"
    sha256 cellar: :any,                 monterey:       "bf3087a631c36d644b5ef484690dc5034dab48892820c73875181c586f8880d6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "503aae86a4d8e195f12a4a751a5732bf809980596d1c59d616f965fdbe2c6b8c"
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
