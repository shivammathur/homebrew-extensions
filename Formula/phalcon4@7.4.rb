# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

class Phalcon4AT74 < AbstractPhpExtension
  init
  desc "Full-stack PHP framework"
  homepage "https://phalcon.io/en-us"
  url "https://github.com/phalcon/cphalcon/archive/v4.1.3.tar.gz"
  sha256 "d6f157e033c7ebfd428190b7fe4c5db73b3cd77e8b8c291cf36d687e666a6533"
  head "https://github.com/phalcon/cphalcon.git", branch: "4.2.x"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "698213179d4aa2366fb52a50ee87564721732a664d9b1a98acfca3e0c80f181c"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b32021468ba9e0e4494c69605a0633243ad6d8a57da733b32b526fa9428b2d59"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5b81f3abdbe3e30ddb565514d8c659832b32214a9ac70512dc4dc114a7305a2d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2f5de667113b80e0a1f0eb014e8fe1448a4149c9fbaa70300250385a3cd30488"
    sha256 cellar: :any_skip_relocation, ventura:        "b5c3ba977c19d47399a893256cdf222bdfc337abf2aaca4219337875eca156ba"
    sha256 cellar: :any_skip_relocation, monterey:       "2e1d57375f40e8fe5fef8685695c07f37656e5fa8a1d0404c08901f104b62fcf"
    sha256 cellar: :any_skip_relocation, big_sur:        "574893c6b06334de52ba0f8ac97174f4bc35d73a983fc2e912a3b76034c131c3"
    sha256 cellar: :any_skip_relocation, catalina:       "0c25404da5e824384ad8f2103af372ea9a5edecd68b33c8fd06ad84bdc9baf80"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "95b7335fa2f15cab6ea6d63469e7cc7d9ad27a3f14689252eeaec89f01e20005"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "85d0921ba00655a998d7d174bd90d99a69591acc6b94b757e428fbb5f3c4f132"
  end

  depends_on "pcre"
  depends_on "shivammathur/extensions/psr@7.4"

  def install
    Dir.chdir "build/php7/64bits"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/phalcon.so"
    write_config_file
  end
end
