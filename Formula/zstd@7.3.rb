# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT73 < AbstractPhpExtension
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
    manifest_sha256 "c4583290e8404d13573a06fc20f8f0976e1bae1faef194610a0e4bab42eedc8a"
    sha256 cellar: :any, arm64_golden_gate: "d0294ea4c5051adf3d8888eba654b3d838df1dbe2a9cd5307244e2477e1e733c"
    sha256 cellar: :any, arm64_tahoe:       "11e54306bfbf5a19d5a55039f581301fc34898d0293ed6f33dab93fb878f56d0"
    sha256 cellar: :any, arm64_sequoia:     "682f160186e9a48e07781683f20d208ca57c14ecf313ca19be4d02ee089fe761"
    sha256 cellar: :any, arm64_linux:       "a4b451147a5da95f5438fef7fece3ebb49c94928302e98ad5e522b5457892439"
    sha256 cellar: :any, x86_64_linux:      "dda1422002f8212a88cc220c4055bc337be873e22b93bb65469466e3735a60ea"
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
