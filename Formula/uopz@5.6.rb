# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT56 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-2.0.7.tgz"
  sha256 "16841e086bb13475438a72b77bb726399476dd04f72b2c63fc0521ef0ec66800"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9e146f46600808f3c0fb6d8f68c46f419bdfb64aedc6b2cee412657eb66b3d99"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bc4584851d5b66c95aa0875282343fbc59c7294b293cc633048abd415dcc6707"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cf829a0be3d537591f6c0bc546ddf84e4a73af1ab7ad28620c4e1e720716f8f4"
    sha256 cellar: :any_skip_relocation, sonoma:        "f510d0b09095d45438aac408b23d813aabbca9f31302d9b76914bba3d9bfae6a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "f16e8dabc22df9cc56a050976382e3a5d8ddd76b9bcb0dd31602fd5573da169f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5651f63465e1feaa4e22de0171cd0ad44cbbe3c211f67d590c08479a228f128e"
  end

  conflicts_with "xdebug@5.6", because: "uopz requires Xdebug 2.9.4+"

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
