# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Zstd Extension
class ZstdAT83 < AbstractPhpExtension
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
    manifest_sha256 "cea5107ef7533703e273264d1efd79e11d97f20bedaefb946c3c39cc137382f9"
    sha256 cellar: :any, arm64_golden_gate: "eddfd24ad734751e34ad755219b57391128649de44df4761425e904dfabe880c"
    sha256 cellar: :any, arm64_tahoe:       "3dce9b9aa0929fa72824354f0bfcad8ae09fb402d28d20bee7f22054bbb5ee7b"
    sha256 cellar: :any, arm64_sequoia:     "268a323d97383586dbf985e4e34a31465cf36e96e5ad1f13ad744c07853314b1"
    sha256 cellar: :any, arm64_linux:       "b1e41b49f7a490516cfd646f249cac3b92542fde9525b1443fcbe70568ab3d42"
    sha256 cellar: :any, x86_64_linux:      "19b8ab05f48d1b2b1946e623ea5f700bdb86053e05127ba78c692c02f8cd7874"
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
