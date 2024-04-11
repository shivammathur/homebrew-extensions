# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT82 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.2.tgz"
  sha256 "46ac184d0f67913ef5fbbd65596bd193a2ef11a7af896a7efd81d671a5230277"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any,                 arm64_ventura:  "4fc6dcfb2938f306f460b1cbdb5932c63a6e7917ed01eb10fd19f8a8f9a286c8"
    sha256 cellar: :any,                 arm64_monterey: "98f4b2489cdc3c46e041232c83edad987e7becc9f71925d6cfceb90a0c5eae60"
    sha256 cellar: :any,                 arm64_big_sur:  "19bbb1b639092b9b4e2034ab9047b62fe2c65795f527d0a6fefc0c549c2538a7"
    sha256 cellar: :any,                 ventura:        "192f0afe2e8e6bf13fa49d68833ad9a886078d402b96711cef1e669399a40827"
    sha256 cellar: :any,                 monterey:       "f6fe922a3970a303f52625a5806820021611abbb6e3e482ec844e10ea00fc6e1"
    sha256 cellar: :any,                 big_sur:        "2401446cdab52cba1981f5b300c771c78d48563ffbc9e743b5101e2a6da938db"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "3a849144c99cd667ab92bbf3e6b0c3f9e9eb695e067c9dafda842bbfc2c561ed"
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
