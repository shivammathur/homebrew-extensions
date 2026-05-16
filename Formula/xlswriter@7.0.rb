# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.0.tgz"
  sha256 "0562a41c958a20780b492f91c3815744d976e42e4adac09edb4d2c5add7b0cc7"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "bc0cea5b53dd3c409cbd47a119829d0c7103337ee48403d68f9c28ae31f1c899"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "151bf18a472b26ca1f260404aace53d8dd7ec47332e33c759cabf1c2e505e9f8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5fd0f7347a91f6cda27b7f6a0dee1e59f24116b4385fafbd606114dc627a298c"
    sha256 cellar: :any_skip_relocation, sonoma:        "0936711fdd051ed2e0167de1ff1de12aeb2fc6d4f00d94adfb0e7669441cd2c2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "32f6546935e4a5a691ee5ea048f30c74cc15e5865c254b5d8bd0fc5aa7be6ce9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "7d6b40b7b84703b3a57c4ad0eb4824e49b63033ba8aa7100c31f49e7b25fb0e7"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
