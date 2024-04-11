# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT80 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.2.tgz"
  sha256 "46ac184d0f67913ef5fbbd65596bd193a2ef11a7af896a7efd81d671a5230277"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_ventura:  "6c76414363957fbd554ef8ce2d4a90c6d449d81ff2e5374b0401b4ee9a1328f0"
    sha256 cellar: :any,                 arm64_monterey: "b01d667ec434287671c31d2bcf803e7e0639c4fd8f367a63e38929574cc78a70"
    sha256 cellar: :any,                 arm64_big_sur:  "982a5405cb2a2a8b99d52ab07a7b3809ad9c295e5c79e8b56feeb2a90cfa45e4"
    sha256 cellar: :any,                 ventura:        "7da7598583fb5d30cad1e8f249104b96f5880c1143fb4251c4421634d923a2dd"
    sha256 cellar: :any,                 monterey:       "0c979b15c63c71d5e1757f0a1690b1de463225d5a1493aeefd391eb2994288f1"
    sha256 cellar: :any,                 big_sur:        "9555abfa2e9a9f176528440891a86a4abc9f48f494d61a5272cc1a552a567d06"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "dde90aa9c6dabf3c473b46d4911f3a88c31eaec1c517b324af70614296c05cef"
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
