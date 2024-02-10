# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT84 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "b732e9cf1ae4b9ede74b4514578a483526b035f75db7966ceddc4fc4fb92c10e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "e3b0beea225fce0309349b55b4d8f62e61e67ea2c61782f5197303338a236670"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "2c2a7a8956ac773660b9f7fc1388ad9b1872ea785826207273d8c78dd7c36e4a"
    sha256 cellar: :any_skip_relocation, ventura:        "0760709ae78f18c2dad691d24487478c50e95ddd24ef2b8f076924e8d7fabedf"
    sha256 cellar: :any_skip_relocation, monterey:       "586ccab17c229e45f0c3ac5ba970fe6ccc898a0fa31599ad0d42091cca2a8a6b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d3a9b68ab1f62117ecb0ab2a7a80720c3fd9474d4b415e820f2ee3739fecccba"
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
