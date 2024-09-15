# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT84 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git", branch: "main"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "589914f1696c06505c811a82617ac16479d12bb776acf423ffabff0b70b3b9c8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ac7d180bae1357a3b3dcab0f094c05c325708978e51e0cb5673fd5d16cf716f4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "959eabcf35e586b35afa6a0b00a680c9c13ffb3cb3febb087e4927a30def513d"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dfdb530466d957cb45395822a6659664e8a81197598ae846481dbe3e85078f8d"
    sha256 cellar: :any_skip_relocation, ventura:        "7a17b54cb350572c21182ac04b9627aedddfedce2193766603c0d4dfac7f18cc"
    sha256 cellar: :any_skip_relocation, monterey:       "2a5e1f0a37bb1e828d5441b45f9c8e0db67d2e76eb218aa217e16481ef2d0582"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "55e598a2eef4c2dc96ddd5439665dbc838f18e29953f56c6c031af67e731f0d1"
  end

  depends_on "zlib"

  def install
    args = %W[
      --enable-memcache
      --with-zlib-dir=#{MacOS.sdk_path_if_needed}/usr
    ]
    Dir.chdir "memcache-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
