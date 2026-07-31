# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.18.0.tgz"
  sha256 "4ec2a8509b398c75442984586b812ddcfc4e1bc6cdf546530fe4142d763e741c"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "42f529f2b961f2f0bba51be9582cb20ed4877da15ad05d018a6b0154d604ab91"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a5e6c8f303eaf0839e9a65985f0ab9268ff4dc766993eb393a904837a806e3ad"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "54d2e761d3506ef69c2cea576ad5cbd69cacbbea590e0dec2ebc626954905de0"
    sha256 cellar: :any_skip_relocation, sonoma:        "5109eed72c83631df557184306851bb0b1e3132bb53845153d07b1c112bfa527"
    sha256 cellar: :any,                 arm64_linux:   "b790370c119eb10b13498ce547d2397cdd9ed8c50dd2b4b608f0f4c3cfb152c3"
    sha256 cellar: :any,                 x86_64_linux:  "47eb7f263b375c00b09924e0d7288b7ab0b94be0fddcc038b02a4d063610c040"
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
