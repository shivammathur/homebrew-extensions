# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT82 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-2.0.0.tgz"
  sha256 "52dfed624fbca90ad9e426f7f91a0929db3575a1b8ff6ea0cf2606b7edbc3940"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "066b3a876fabca92f06741a1eaf46385f0d650490e82b0f96f9d3c0c5f132559"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "108afe75b8f13bf1c062bb4bd28ec4abb28110bb1f20db8960ea3d2eaa30ca94"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "b6dd4636c6ba09162df078018e8c3b952c20542f3b27029dd17dda45548720e3"
    sha256 cellar: :any_skip_relocation, sonoma:        "2b1c3e704b95eee214c04d7a6e1f6d8a2d353899adc6220b651d853b7550c1c2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "637d263742f61316124c3cc708e0e925e7a6e4921920715eb6df7eb7bf34533d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bda53694149ba2a639226c2ac356c88779c0e7a6e9d451a0af1fb9e91820b0dc"
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
