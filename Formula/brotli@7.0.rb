# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT70 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.18.3.tgz"
  sha256 "ed3879ec9858dd42edb34db864af5fb07139b256714eb86f8cf12b9a6221841a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "fc699653a33790aac0dfe2262369869ffb73dd1ddc335428744af0c77544fddc"
    sha256 cellar: :any,                 arm64_sequoia: "cfd61bec08177e6a5ae74c6645c2b2d9e23b5ef7b4341648175bbfaa36df6e85"
    sha256 cellar: :any,                 arm64_sonoma:  "2eddeb066e5b8799aa60b378a5858489140e5a5f4e10eec1227b3317e994e1aa"
    sha256 cellar: :any,                 sonoma:        "cc6618c1561a62afee4d932f19dc06649948f74abb34f032dccedcf864a63546"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a3d01cb5c89daa5d7d604271967f1fe7fd91004555af90117c921e11d0001818"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ce3ee3baa587a485106babf060a862cffa0ce36f796ea6faa2ebf1560b3ee190"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Formula["brotli"].opt_prefix}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
