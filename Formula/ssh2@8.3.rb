# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT83 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_ventura:  "dea40a205d0434c07be0915141594aa7031d0577054afe54d00bef12ac9c8ab3"
    sha256 cellar: :any,                 arm64_monterey: "dda95c9d6ce3a29230574c376a847f7ec22171f57f855798faebccf8c705a916"
    sha256 cellar: :any,                 arm64_big_sur:  "2127adbdc7254556d1a36d63158c8e02840fd00f65cdb5044ea170501bd239a5"
    sha256 cellar: :any,                 ventura:        "8ec3fa27056fcda727c04a079a1303aaf2ab03193499350e77b9b3ae5196e350"
    sha256 cellar: :any,                 monterey:       "da3378a9033761caa3c1585009377a2cd5f54750d049fc321a59ec8cd6d38da0"
    sha256 cellar: :any,                 big_sur:        "0c7921826ae10f2f20d3759fd06f3f19291ea326f8eeb79dd0c281189790203b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "08c9da0410c5a4c3fda1a2d987441f011ae6727d172ff8e8ea891bd7ffa8102a"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
