# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT85 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.0.tgz"
  sha256 "46592a6576c2f42927659dd00dc6c3f39f1fcae7374e95e1f4e11f8ce4f477fc"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "8dfbb1e1a8732595cffed297a2e41d76539827d56d194912cf41ebb5296f3ddc"
    sha256 cellar: :any, arm64_golden_gate: "5bcf26f289dfa3f571f67f616cffac89afab00e1b44ef6ae52eb755422d44ffa"
    sha256 cellar: :any, arm64_tahoe:       "cee9a65e36c0bff14fb72895682b5d29ef27ed65e76489868048991f72c590cf"
    sha256 cellar: :any, arm64_sequoia:     "2dac34545141dc96a2b0110aa05d92325f4e68c616eedc544e6bf19645daf3d8"
    sha256 cellar: :any, arm64_linux:       "e310f7d0d219639c02825f3ba9789fc2efbffbdbd6ddc7fa16d379b05801a9d6"
    sha256 cellar: :any, x86_64_linux:      "2ac6086e1f64f3aa1c1f1653d63bd90e79b3a5167be3b46887614c454285ccbd"
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
