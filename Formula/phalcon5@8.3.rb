# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.8.0.tgz"
  sha256 "d80b137763b790854c36555600a23b1aa054747efd0f29d8e1a0f0c5fa77f476"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon5/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "f9b2f1c5fbcbfe16effd31617ee1a3357b484628bb059997ff078b7ad7158266"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "27e9c9adca8fb8e1f31d5ec6e10c1012a6b54f43aadde30268c29951ec5575c4"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "a00eb4d8eab889c9084cdd06a47d048783b508ee255c21322244952ad66ce65f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "dd6f89d2d4bd172871dbad825dd7f339c0c30e79b1ca1efea13bf4d7d387d39f"
    sha256 cellar: :any_skip_relocation, ventura:        "51e02e25d2e7f6880e7b04731a926bd42a3bb163d7818ba22e4d71b9eb71e03d"
    sha256 cellar: :any_skip_relocation, monterey:       "038ebc726053f60a5d35cdf9f942b515eb552869687462f6cfffba3398e09760"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "24b355686ab80a4c67dafc7cb1acaac6b7836809cd926543a3921a2a175ba03c"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
