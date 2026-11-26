# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT74 < AbstractPhpExtension
  init
  desc "Zstd Extension for PHP"
  homepage "https://github.com/kjdev/php-ext-zstd"
  url "https://pecl.php.net/get/zstd-0.19.1.tgz"
  sha256 "b280d9e9c146586648b0d4c14720220b9e1aaa1a3083a31ab1665784c90601d0"
  head "https://github.com/kjdev/php-ext-zstd.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/zstd/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    manifest_sha256 "bea98390928b5d4a7647e34416ad45a81500e0f4f39cac24163f5a7b718762fd"
    sha256 cellar: :any, arm64_golden_gate: "c2f2355444b20cf9257b1eb9a04fa791fe3e3a183274c1b2f777b8e45f2b0d3e"
    sha256 cellar: :any, arm64_tahoe:       "34bcbb8b6e7e844a64bfcf0cae0864f8ee7986875b1fd13a07e816bdacb093d6"
    sha256 cellar: :any, arm64_sequoia:     "92973a5c5b88940d8401d5bccd6a3fadce0a609f2619be09e13a35d98198be8b"
    sha256 cellar: :any, arm64_linux:       "621d5ca598f9fa648f0de94b7a8347e3cb9b481275e0c28468fe6431f41050b5"
    sha256 cellar: :any, x86_64_linux:      "dd1b6d823bb6003c0f8d7576eb22f0d22c6e47c40b5b484dbc7b25b84c9db589"
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
