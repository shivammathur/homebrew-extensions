# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT85 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "3c57688fe48610a42a50231276d5afa93b2bab669e28465d08847ed056053dba"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "480fb866d8bc6c416797094c3a568d309fbb4abf4dbbae109066d77d6c50ad38"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "59c408e2c05942647596ce58915d27a933d4423700d0e61956e34e448880a4ea"
    sha256 cellar: :any_skip_relocation, sonoma:        "47421bbdfc434550e73505c6fd8ef1d1fbee19fc6a72df6e2935a4d722ef022c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b6062894175936f37470c18668823ca4b1e0c0fcd9fc023c61059a7eef5bdeef"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "af43b353387241b4d7745b8e6170c60990427d612980fe51cf74ea2af5e1e08b"
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
