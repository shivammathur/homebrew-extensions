# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT86 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.9.tgz"
  sha256 "ecb3d3c9dc9f7ce034182d478b724ac3cb02098efc69a39c03534f0b1920922b"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "cf47723f6df40c9c040df9ce99974a401b4c5b5f27560c4747103be9f1edace9"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "99f5d21acb0ea8fa129908cf57d505102eb1e044efc8f37bbd8daf2cc4193854"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0f46741c58451ce773824f609b51df83aa4812252d1f9b707fbc72cb2feebee7"
    sha256 cellar: :any_skip_relocation, sonoma:        "4c0c72fe4944e3f81573db8a1473125da92a56e5bc18c6d124e7fc599504c4c4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "dff7497efe7bb8fa9e15522a961b8ef33aa4ee67257068e3931fbaf708713e34"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4d1fca0c22a8306d3ac821aa911f32a6944b0079f5019345eb6f64995ffd2df3"
  end

  depends_on "re2c" => :build

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
