# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT72 < AbstractPhpExtension
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
    manifest_sha256 "79fa102cfaffe1e2b9ebee432820c9e0eb1a8654de6af565fbc6bd6edf5d1033"
    sha256 cellar: :any, arm64_golden_gate: "79a16909f5de84509a4235a305315ed3aac80f179b41483f9e9d983341f08f9d"
    sha256 cellar: :any, arm64_tahoe:       "8a3476aa9a6317bd765d2edfdcc89d1960b47c91b097af05b31ef8dadce178c1"
    sha256 cellar: :any, arm64_sequoia:     "922cbe114448f590992619825687fefcea9d83fad81a4148dc6044f9cd0473f7"
    sha256 cellar: :any, arm64_linux:       "0c2ae36c3d58b6638a72c3dd5539e7f9c8a92c0ce2ba879f4a3c1084cc3e7c33"
    sha256 cellar: :any, x86_64_linux:      "77c579604d13eca581873dab1260393466037ca90f26afd78efcc12983adaa31"
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
