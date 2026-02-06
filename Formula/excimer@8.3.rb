# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT83 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.5.tgz"
  sha256 "cf49acd81a918ea80af7be4c8085746b4b17ffe30df3421edd191f0919a46d1d"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "260e25ef5db2cbd2d54b31fd84ee39928a54879ccfdac83354257a08504acfcf"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "127789db74c2646e2ee5a0adc096d6f14bd34090004050181d996d0c906453fd"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "8843e246d189ced0fd418a254179ba3dccccad75a6b935776d4a664f429b724d"
    sha256 cellar: :any_skip_relocation, sonoma:        "62cd0d05c5999ddf5002a258abb1b526133ee5dbc89b9ad2cb03bbfc032e08cf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a1c41905fa790906f1a68843a33b3a1b1943093107795416df9b19d92ccbf82a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e08e70179b8c36610883472fd68eb73759657f8932c1b525edefa9672f6376f7"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
