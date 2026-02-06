# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uploadprogress Extension
class UploadprogressAT56 < AbstractPhpExtension
  init
  desc "Uploadprogress PHP extension"
  homepage "https://github.com/php/pecl-php-uploadprogress"
  url "https://pecl.php.net/get/uploadprogress-1.1.4.tgz"
  sha256 "9ba0f010f78889b8d69c5c643a9c920d1e140cd1d06817b8bf4ee76f996138c0"
  head "https://github.com/php/pecl-php-uploadprogress.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uploadprogress/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "face8eba2de6d201867f25ff450f45566695c2fa27e0079f72bf1e77b85b4503"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "44ef4d2e3e2d49925b61f6cb4b76d82c777226b1624fe670116a0e08e0295b7e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "08e81547ca0c63891a5e60a7f32deb6a669364cbc10ec45dc0316139fb712f2f"
    sha256 cellar: :any_skip_relocation, sonoma:        "a8f0d24e21880d010f8712c9e3db906d044a477d326254170a01e1e60b18d7e5"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9b51310598763faabb28e573d1b6aae6f56c9e78a6ad58a2addd79b34be81e39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "a8e672b8da7f0248212d87736472743b326c46025cf9ff402cb40908ca5badb8"
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
