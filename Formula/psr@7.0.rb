# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT70 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.1.0.tgz"
  sha256 "4feb8eeea4237894bcab1ea064cefc3421c909778d39c977184c16e725cfbfb2"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "8ed193ec5bc9f0a74ee7bd4cb7f4f5dedc3f60c10f6b4ed2b1976c4ad114e521"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "ae9d13c32c148f11bc42dc3e1d481eb918da4e5b203f48432ce07892c7da538c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9f86315905464ac800ad4a343c01bc2f450f9da7609a6be5b193729fc6a3a0cf"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "37ea101f9afd58c2ac104a7168d1a2731a6ecd700e655f816395d39ffd7e9efa"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ddf7a04011c16419ecb42ad7612bfc13579137ba6eb8a89523e90a086c278673"
    sha256 cellar: :any_skip_relocation, ventura:        "4c8368fae4ca3cb3dbb2c5aaddc3d90e45ee6bf2a213fa045197d3f93abf3c1b"
    sha256 cellar: :any_skip_relocation, monterey:       "a977ecb7017d31443dc7203cba8dbea0d17699ad221496c8c5712997791f7700"
    sha256 cellar: :any_skip_relocation, big_sur:        "e312a44a5a785d5beab54d3434eb7f3aa4a6ec7408c2ea255f975a606b7f974f"
    sha256 cellar: :any_skip_relocation, catalina:       "281956113992a7c38cd80b672200f7deed6e586587acbb0d4fa2ade0a6d4273f"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "9aece9f38e5b9e00c1629f03072c0d3e7ab460ae02cd9bc2325939d68705f210"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d1eda1b8edbe513e6207ffeb93a69aeaa8e5149ad66732440af074b8f05f95eb"
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
