# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Event Extension
class EventAT84 < AbstractPhpExtension
  init
  desc "Event PHP extension"
  homepage "https://bitbucket.org/osmanov/pecl-event"
  url "https://pecl.php.net/get/event-3.1.3.tgz"
  sha256 "854a0bf07c6f3fedad398186ec71c3cd1bb8d35651e3f3341657a616a6981707"
  head "https://bitbucket.org/osmanov/pecl-event.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "fd4bcc3331299fb091840220fcd6eb74b0871a83ff1a7e6bdfec521b11922294"
    sha256 cellar: :any,                 arm64_ventura:  "e13b8566a2093ff380fc7ca6460583ca8819282f6704970f2e7e69e293c490f8"
    sha256 cellar: :any,                 arm64_monterey: "301d6de53e12fdc4b7e3697aa72dee82c1678144a7b409caa5588e0167f53e43"
    sha256 cellar: :any,                 ventura:        "15d525c426776afeba8b319bf1ee9eae2ed113b493054f34c5a54bd161bff353"
    sha256 cellar: :any,                 monterey:       "d357672acd94ec0aec2f066b8308ce7d20189e12f84114ba69f11d6b9092eaca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1e1ab3a63073f36691c89485d08654f83948c29318c635b7a84ab6245a9b3899"
  end

  depends_on "libevent"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-event-core
      --with-event-extra
      --with-event-openssl
      --enable-event-sockets
      --with-openssl-dir=#{Formula["openssl@3"].opt_prefix}
      --with-event-libevent-dir=#{Formula["libevent"].opt_prefix}
    ]
    Dir.chdir "event-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
