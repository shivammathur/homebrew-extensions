# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Vips Extension
class VipsAT81 < AbstractPhpExtension
  init
  desc "Vips PHP extension"
  homepage "https://github.com/libvips/php-vips-ext"
  url "https://pecl.php.net/get/vips-1.0.13.tgz"
  sha256 "4e655843e5ee8150c927c10853dfa0d2a3b924bc2453ed8fb5e5a2a90e686f8f"
  head "https://github.com/libvips/php-vips-ext.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 11
    sha256 cellar: :any,                 arm64_sequoia: "90360508355a3193fead44c5aa7b25879d804e2a36b215f06fd35137a794ec1b"
    sha256 cellar: :any,                 arm64_sonoma:  "d973831bd21a4a58eb79d46afc0e4a5d243c0243ddecf898766e1e1ef04536e4"
    sha256 cellar: :any,                 arm64_ventura: "8a4e6fdbfb48021dfc1583a5e60c018aaea360cf4115aee03e42808fe7ceb4b4"
    sha256 cellar: :any,                 ventura:       "5f3112770a1f43cb34e50c2f0b929a73b341206b355d23342508876e4c45a0ec"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "cc6c09a4cf061a8bd7b6c93874b44c57a4d73d7048da7c4afe1e673fcec130f2"
  end

  depends_on "gettext"
  depends_on "glib"
  depends_on "vips"

  def install
    args = %W[
      --with-vips=#{Formula["vips"].opt_prefix}
    ]
    Dir.chdir "vips-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
