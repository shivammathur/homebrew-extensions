# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT70 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "7622eb44bfbabfe80a379813533b8d47b31854ef603dc38d4d6e3107681d625e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e23da636d30593de9484dca84c687f4cd5d7dd6ae481836758b5978d03600f0e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "86d3dfc8fa8d8f9ca07bc542d835d721b82d81b0f55d55e53ed93e8098b96f5a"
    sha256 cellar: :any_skip_relocation, sonoma:        "c830bab70bbf466e7ddcc09145d0baa4296d2b78f8aa3aeeb5cbd9c4d60af571"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8616aad095ced464c70e30fcac0eb68e8c40001fa26230daf1ffde1abfa34dc9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f4511d79a470b54a848e6ffd825afc44585c0b1b91c25aabb683bdef0a6b4b57"
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
