# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT84 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.13.3.tgz"
  sha256 "e4dfa6e5501736f2f5dbfedd33b214c0c47fa98708f0a7d8c65baa95fd6d7e06"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "99c7a791e4b913772751651c7c984bffc5ef3e1723496d37c2258c37ef15d1c1"
    sha256 cellar: :any,                 arm64_sonoma:  "ae00677ab44d1da81f9ee32425e9c0f23f9a41a0873b38d9f1e3fc41c48ae6ef"
    sha256 cellar: :any,                 arm64_ventura: "c17e7fdda31cf29805faf388bb45b4793468a56361c711f9cd986de56fe41566"
    sha256 cellar: :any,                 ventura:       "775bf939cc00ead8d5932333c298bf10c16c7eebb7dd800558ae3077e7d0bb27"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "02bb8e1ea179622e2af54570f8ca2f09ee86eab9bc04ccc78f8dc91d8194428f"
  end

  depends_on "zstd"

  def install
    Dir.chdir "zstd-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", "--with-libzstd", phpconfig
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
