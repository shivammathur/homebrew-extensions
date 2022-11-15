# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT73 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.1.tgz"
  sha256 "da3566db17422e5ef08b7ff144162952aabc14cb22407cc6b1d2a2d095812bd0"
  head "https://github.com/m6w6/ext-raphf.git"
  license "BSD-2-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "bbaf3642f996842a3be45c4fcf61b4ebe6ef5cbebedb5c8ada239d9b1baae77c"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "a5972ac5f40c3fc94d822554ffd59ae97781dc650952de3497b60c8491eae0a0"
    sha256 cellar: :any_skip_relocation, monterey:       "5d9ec42381d1c0d38ed349eeee9db0044a92d79bed3d2da0e1dce34eb856c2d9"
    sha256 cellar: :any_skip_relocation, big_sur:        "bce2f5e12ab8e377431ac7927c8324f6662cdd1ce466c6cbcfdbb26acd407162"
    sha256 cellar: :any_skip_relocation, catalina:       "438792455753c73021cb50ba1a7aab18348287947bb378852330da703c4e64cc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "41bb09bbbd920851abcfbfcf76a064a52c8eb69c970d84c98c77f0ba88f7cb9f"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
