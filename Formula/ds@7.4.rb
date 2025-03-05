# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT74 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.5.0.tgz"
  sha256 "2b2b45d609ca0958bda52098581ecbab2de749e0b3934d729de61a59226718b0"
  head "https://github.com/php-ds/ext-ds.git"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "03f7b5081f6a4d7044eb9a15a6fb10aa07bcd7d9a6928ba438f3492d3629498c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3c948f18d2802a09c0a785044c008214961ff3279eb4ae741fdd57bd300ff4d2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "57e3688898e1cf3f78772b9bf892cce38eba6eac46a4b517e3909dbbcd1f6296"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "748ba6f15c547fab1c5b9188339cf48953de0b06796c5b2f25d87587a4011369"
    sha256 cellar: :any_skip_relocation, ventura:        "3f4a02c456370e0a704b6a325a7fa382003634e21b20e87c2f86e1b31d294c94"
    sha256 cellar: :any_skip_relocation, monterey:       "8c695f2b39128858f905988b6367b154cca41ee3139c853f3ea30530314e6a59"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bce4fae0330e289b565ed73659b67103e89e6d01ad008ef4964a615fdd06083a"
  end

  def install
    Dir.chdir "ds-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
