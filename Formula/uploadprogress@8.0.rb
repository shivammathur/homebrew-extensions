# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT80 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-2.0.2.tgz"
  sha256 "2c63ce727340121044365f0fd83babd60dfa785fa5979fae2520b25dad814226"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "30a61f63e019464af8b3a867adce8d630f8473063267503ed12158a64bcf1370"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "81ec092d018bad0e28b7aede0567d1b3832dd7f49ead205af414f911b75cfd57"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "75e9a845b673b015ed4219fff50e773dcbba09d82a2998249389c9264425d6b9"
    sha256 cellar: :any_skip_relocation, sonoma:        "5b31ae2ec6e0809c771fab1178af1b68410b9561ce6d9b1e889a8f8bd88767dc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8fb89fcf9599f19feeffbfaaa5b15f0caee96586f975d3032a50905050f6bb7f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "3d80aa1dad89598b79562b9ce54f23508a0314f84857bfe18f8eab130f24af3c"
  end

  def install
    Dir.chdir "uploadprogress-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uploadprogress"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
