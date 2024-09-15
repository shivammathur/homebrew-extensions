# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Memcache Extension
class MemcacheAT81 < AbstractPhpExtension
  init
  desc "Memcache PHP extension"
  homepage "https://github.com/websupport-sk/pecl-memcache"
  url "https://pecl.php.net/get/memcache-8.2.tgz"
  sha256 "b3f0640eacdeb9046c6c86a1546d7fb8a4e9f219e5d9a36a287e59b2dd8208e5"
  head "https://github.com/websupport-sk/pecl-memcache.git"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "d6f52e6fabdadb32988afe720a57f162640765f48d6ad97f2729937c09fca1ab"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fdd365bd815ac79848eef92a07af589a06648afc595c0095d6ec49c9604cee61"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9d137ea3491d56f0ac567004cffca8172bf98bb0dc7db66dcaa0afb73dce66f2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "01377665122a6b170ee904a4b43a1be20ebb14c7b4a91d37fd01efda17a17734"
    sha256 cellar: :any_skip_relocation, ventura:        "c1ac1c29823e1a514c3d5191a4e78586a3bd42e24f1b965f9f0de5ae020970f5"
    sha256 cellar: :any_skip_relocation, monterey:       "7d9f89fae342050d4b777a9450b8173775a1452b76e2bebf2fe1c94cc7bdb804"
    sha256 cellar: :any_skip_relocation, big_sur:        "6452afe5bd26c2945e2ee7e0f173ddfd161b60361beb6f6e543bef98378e2794"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6842338da57697a1833b62e532cca6706604f868c6e7fd4365787c350ab721a0"
  end

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
