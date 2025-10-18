# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT71 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.1.0.tgz"
  sha256 "4feb8eeea4237894bcab1ea064cefc3421c909778d39c977184c16e725cfbfb2"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "c10775c494e48c0e20f5868be6831842f4c6711261345067c2d184bfec2ab071"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "a64dfe4d69f90333a13bcd08aefadaddfdabace1fa7220ca364b68d7d369da51"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "c4ede10c37d8678b5244c2a15fd1fef2d44c13f4965e247ea64244f2e4fbd72f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "49e7d496f6eb10df4bccf14636c52ca209cb87f518ec9579366e1ff9f14c0eb7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "62dd91da91914ad6d8bc2577e2cb63488d5a60371c13642c355fc3cbd9b4a2ed"
    sha256 cellar: :any_skip_relocation, ventura:        "f4937b0fbb8dd50cc3d42d0bec24d1ce459b01b5107ee41876a30fc6fe545aa4"
    sha256 cellar: :any_skip_relocation, monterey:       "f7da2d72d9406a10507871a44adf44eb1a4236b33e960bbb380da6fbf9bebc46"
    sha256 cellar: :any_skip_relocation, big_sur:        "5d7f7b93b800634cf21d906f1bdf3e136a43394be268b52c5afa58f4f9fdfd82"
    sha256 cellar: :any_skip_relocation, catalina:       "1deaae07490c896ece32d55ba3f6d5a9e38797d0d96066e693584846356d5b89"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "902e06790ca793ae3621d1c9a05b5d0608cc80f1a5d36b5df5e60e39a4c0911b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "70d7d4de1aece679a04721255787d4f29f70a65a5b08ad3dff26bf4844f61495"
  end

  depends_on "pcre"

  def install
    Dir.chdir "psr-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-psr"
    system "make"
    prefix.install "modules/psr.so"
    write_config_file
  end
end
