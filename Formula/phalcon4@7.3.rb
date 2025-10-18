# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon4AT73 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v4.1.3.tar.gz"
  sha256 "d6f157e033c7ebfd428190b7fe4c5db73b3cd77e8b8c291cf36d687e666a6533"
  head "https://github.com/phalcon/cphalcon.git", branch: "4.2.x"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "b72d21356eefcff02bdf3117ac8108373d369914b2a664e9caa59a2712c758e7"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "ad50dc11b3375b28e9ef915b5e5f861b045f512f45a90dc8ef593b42f50feda3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "9808ae72409ddffe2183b50c998fc92d4170c24b167987b5a9ca90a42241917d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6315b013d3748a99c8401830a788f284c66e94c4e4c062c915bca72e4593adbd"
    sha256 cellar: :any_skip_relocation, ventura:        "55820978a0a9c1d2036f4eefeca9c14dec924a712383f24609e547a10e0b7082"
    sha256 cellar: :any_skip_relocation, monterey:       "c6e78865cb9bda4c74c953fae6c1d64bda6cebb6cb9afabcf4d99d8623958ea2"
    sha256 cellar: :any_skip_relocation, big_sur:        "b46f31b55478805cc0d430cbd2d2cfafd056dd21c1f8f2b11b6175a285eab84b"
    sha256 cellar: :any_skip_relocation, catalina:       "eaf4874c086e4498856da3267a75c3324341b3772e84360276c06e72976f6ecc"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "e6aff150a4a81b44078923fc677b0b6b8341f1751d13812e75502494753271b1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d34a4ce2ffc14d92e6726b4edd59d925a0db4e4b14f0660983f9e8531d987b64"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.3"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
