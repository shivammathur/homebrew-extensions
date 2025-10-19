# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class PsrAT80 < AbstractPhpExtension
  init
  desc "PHP extension providing the accepted PSR interfaces "
  homepage "https://github.com/jbboehr/php-psr"
  url "https://pecl.php.net/get/psr-1.2.0.tgz"
  sha256 "9c3d2a0d9770916d86e2bc18dfe6513ad9b2bfe00f0d03c1531ef403bee38ebe"
  head "https://github.com/jbboehr/php-psr.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/psr/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "bb09c5c4f2f01254515cb3f44d718ecc59b8a9ce71fe74a750c833940a2515f9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "6db0261ac0ef7ae50d31c9f619a860cd8d4853c34537f9d4ad1ea5f6a08bedda"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "380809c3c7c83e3057568fd8c9ecf2de60eba1e3aa92c7baa7a2936bff2fc4f6"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a258b3db25cb5c2cd7f2acbf7abc631055db101f91f8228861b7d3d74aadb40b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2fcba9ffe08c3f4bbc26e175c6ec3ff226a3da02e476db5566501bbde5163875"
    sha256 cellar: :any_skip_relocation, sonoma:         "c9f9bc0338c0eb7cb8db44223fb9a70ba95c549a6410dadd36119afcece00480"
    sha256 cellar: :any_skip_relocation, ventura:        "cd57dd4391033afa6f335bd8378eba2fc0ae8ab140a57db7f51519107629c665"
    sha256 cellar: :any_skip_relocation, monterey:       "52b4365138723f893e98e567994b9aa6417bc3388d9267f47d1fc6e2812ed06a"
    sha256 cellar: :any_skip_relocation, big_sur:        "65fa799732159ee765720d3de6d6868a7164f23ab765dbc4bd9d7bb3fe7ae612"
    sha256 cellar: :any_skip_relocation, catalina:       "06be1d756c30838e24e064ff16677a501a3ca526d18c0ac645fe3fc024b1f907"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "34f8a7eba8f8d3bcb27671c052c091504698669f2edd628e1054c34d72de38cb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f548e19ba5b850f9a5523d93bf6dee584ff9694c8fad755bbb393a0ebf335e48"
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
