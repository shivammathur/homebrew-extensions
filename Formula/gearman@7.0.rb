# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT70 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_ventura:  "5294a90cb705cb2ad17eb4bf31a17523b845474a2cf958316511cd956669495d"
    sha256 cellar: :any,                 arm64_monterey: "93f553898b586149c119ca34afa9c32d2b5f41a3b6a0066bc17a869c7df751de"
    sha256 cellar: :any,                 arm64_big_sur:  "f148e22d4e17e2d70ed3ded3de94a12c5631f3f566ce5c9d45260fce6035e4e2"
    sha256 cellar: :any,                 ventura:        "1fc29e9a060883a71ca0c0fb7d044ba8d454a871546b84be322b0fd6fbfd50c5"
    sha256 cellar: :any,                 monterey:       "07547ad65b7c89d5764a4aecf220e24579def4107ba2c67c141dfab14c23320c"
    sha256 cellar: :any,                 big_sur:        "296fecb056a8bd391b274d9bacc53d9eef53a491da5b7382e6862d4a6e0a2a92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9e0619abaf39b178e065495c8ae35b948634b5f1c6e0c6b1ef3d6e493e99ee34"
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
