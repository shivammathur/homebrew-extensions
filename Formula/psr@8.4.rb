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

  livecheck do
    url "https://pecl.php.net/rest/r/psr/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 4
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4c569850ae4c54cabe0e41400aeb93a912f8542838619e900bcd4b9d3cf8c10d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "161b422bf54ed2fa120e63260dfa4b05bb5592a9915adc87319bd8633ba9ac9a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "c46ddaca8d83dfd497d1f5e5b0b947356dd6abc0407682b1d1a7159173ea3ba5"
    sha256 cellar: :any_skip_relocation, ventura:       "9c89e4c590ab148f75e831497bb31c84396b0a5292a5a58298e91786060567b3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "ce7f43605c79e7192fca51f6376223fdfc51545f24f901073018b3307db9ec75"
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
